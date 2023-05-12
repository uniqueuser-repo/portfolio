import NavBar from "../Navbar";
import Footer from "../Footer";
import getAllPostMetadata from "./getPostMetadata";
import PostPreview from "./postPreview";
import { PostMetadata } from "./PostMetadata";


async function Blog() {
  const postMetadata = await getAllPostMetadata();
  const sortedPostMetadata = postMetadata.sort((a: PostMetadata, b: PostMetadata) => {
    return new Date(b.date).getTime() - new Date(a.date).getTime();
  });

  const postPreviews = sortedPostMetadata.map((post) => (
    <PostPreview key={post.slug} {...post} />
  ));

  return (
    <>
      <NavBar />
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-8 md:mt-32 max-w-screen-xl mx-auto mb-8 md:mb-32">{postPreviews}</div>
      <Footer />
    </>
);
}
export default Blog;
export const revalidate = 21600
export const metadata = {
  title: "Andrew Orlowski's Blog",
  description: "Andrew Orlowski's Blog. Andrew is a Software Engineer and ex-professional VALORANT player."
};