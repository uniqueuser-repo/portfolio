import { PostMetadata } from "./PostMetadata";
import AWS from 'aws-sdk';

AWS.config.update({
  region: process.env.AWS_REGION,
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
});

const dynamoDB = new AWS.DynamoDB.DocumentClient();
const metadata_params = {
  TableName: 'blog',
  Key: { id: 'metadata' }
};

const getAllPostMetadata = async (): Promise<PostMetadata[]> => {
  const result = await dynamoDB.get(metadata_params).promise();
  const resultPosts = result.Item?.blog_posts;
  return resultPosts;
};

export default getAllPostMetadata;