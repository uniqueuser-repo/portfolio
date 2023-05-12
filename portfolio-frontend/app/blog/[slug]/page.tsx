import Markdown from "markdown-to-jsx";
import matter from "gray-matter";
import getPostData from "../getPostData";
import getPostMetadata from "../getPostMetadata";
import NavBar from "../../Navbar";
import Footer from "../../Footer";


const getPostContent = async (slug: string) => {
  const content2 = await getPostData(slug);
  const matterResult = matter(content2);
  return matterResult;
};

const PostPage = async (props: any) => {
  const slug = props.params.slug;
  const post = await getPostContent(slug);
  return (
    <>
      <NavBar/>
      <div>
        <div className="my-12 text-center mt-8 md:mt-32">
          <h1 className="text-2xl text-slate-200 ">{post.data.title}</h1>
          <p className="text-slate-400 mt-2">{post.data.date}</p>
        </div>

        <article className="prose dark:prose-invert mx-auto mb-8 md:mb-24">
          <Markdown>{post.content}</Markdown>
        </article>
      </div>
      <Footer/>
    </>
  );
};

export default PostPage;