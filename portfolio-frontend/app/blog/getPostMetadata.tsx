import { PostMetadata } from "./PostMetadata";
import AWS from 'aws-sdk';
import { Result } from "postcss";

AWS.config.update({
  region: process.env.AWS_REGION,
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
});

const dynamoDB = new AWS.DynamoDB.DocumentClient();
const params = {
  TableName: 'blog',
  Key: { id: 'metadata' }
};

const getPostMetadata = async (): Promise<PostMetadata[]> => {
  const result = await dynamoDB.get(params).promise();
  const resultPosts = result.Item?.blog_posts
  return resultPosts;
};

const getPostData = async(): Promise<String> => {
  return "";
}

export default getPostMetadata;