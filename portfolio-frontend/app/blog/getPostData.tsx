import AWS from 'aws-sdk';

AWS.config.update({
  region: process.env.AWS_REGION,
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
});

const dynamoDB = new AWS.DynamoDB.DocumentClient();


const getPostData = async(blog_name: string): Promise<string> => {
  const blog_params = {
    TableName: 'blog',
    Key: { id: blog_name}
  };

  const result = await dynamoDB.get(blog_params).promise();
  const resultBlogPost = result.Item?.content;
  return resultBlogPost;
}

export default getPostData;