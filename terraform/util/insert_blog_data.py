import boto3
import os
import re
from typing import List, Any
from BlogPost import BlogPost 

# The path to the blog dir when the working directory is where we execute `terraform apply`
path = '../portfolio-frontend/app/blog/posts'

data: List[BlogPost] = []

session = boto3.Session(
    aws_access_key_id=os.getenv("AWS_ACCESS_KEY_ID"),
    aws_secret_access_key=os.getenv("AWS_SECRET_ACCESS_KEY")
)
server_table = session.resource('dynamodb', region_name='us-east-1').Table('blog')

for filename in os.listdir(path):
    if os.path.isfile(os.path.join(path, filename)):
        with open(os.path.join(path, filename), 'r') as file:
            content = file.read()
            
            # Extracting title
            title = re.search(r'title: "(.*?)"', content).group(1)
            
            # Extracting subtitle
            subtitle = re.search(r'subtitle: "(.*?)"', content).group(1)
            
            # Extracting date
            date = re.search(r'date: "(.*?)"', content).group(1)
            
            # Extracting slug
            slug = re.search(r'slug: "(.*?)"', content).group(1)
            
            # Do something with the extracted values
            print("Title:", title)
            print("Subtitle:", subtitle)
            print("Date:", date)
            print("Slug:", slug)

            blog_post = BlogPost(title, subtitle, date, slug, content)
            data.append(blog_post)

blog_post_previews: List[Any] = []


for blog_post in data:
    blog_post_previews.append(blog_post.blog_post_preview.as_dict())

    server_table.put_item(Item={
        'id': blog_post.blog_post_preview.slug,
        'content': blog_post.content
    })

server_table.put_item(Item={
    'id': 'metadata',
    'blog_posts': blog_post_previews
})

            