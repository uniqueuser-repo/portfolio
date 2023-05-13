from BlogPostPreview import BlogPostPreview

class BlogPost:
    def __init__(self: str, title: str, subtitle: str, date: str, slug: str, content: str):
        self.blog_post_preview: BlogPostPreview = BlogPostPreview(title, subtitle, date, slug)
        self.content = content