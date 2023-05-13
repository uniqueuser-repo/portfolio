import Markdown from "markdown-to-jsx";
import matter from "gray-matter";
import getPostData from "../getPostData";
import getAllPostMetadata from "../getPostMetadata";
import NavBar from "../../Navbar";
import Footer from "../../Footer";
import { PostMetadata } from "../PostMetadata";


const getPostContent = async (slug: string) => {
  console.log("slug is " + slug);
  const content = await getPostData(slug);
  const matterResult = matter(content);
  return matterResult;
};

const PostPage = async (props: any) => {
  const slug = props.params.slug;
  const post = await getPostContent(slug);
  return (
    <>
      <NavBar/>
      <div>
        <div className="my-12 text-center mt-20 md:mt-32">
          <h1 className="text-2xl text-slate-200 ">{post.data.title}</h1>
          <p className="text-slate-400 mt-2">{post.data.date}</p>
        </div>
        <article className="prose prose-invert mx-auto mb-16 md:mb-24">
          <Markdown>{post.content}</Markdown>
        </article>
      </div>
      <Footer/>
    </>
  );
};

export default PostPage;
export const revalidate = 86400 // Revalidate every 24h
export async function generateMetadata({ params }: { params: any }) {
  const slug: string = params.slug;
  const metadata: PostMetadata[] = await getAllPostMetadata();
  const matchingMetadata: PostMetadata | undefined = metadata.find(post => post.slug === slug);

  if (matchingMetadata === undefined) {
    throw Error("No matching metadata for " + slug);
  }

  return {
    title: matchingMetadata.title
  };
}