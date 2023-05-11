import NavBar from "../Navbar";
import Footer from "../Footer";
import getPostMetadata from "./getPostMetadata";
import PostPreview from "./postPreview";

async function Blog() {
  const postMetadata = await getPostMetadata();
  const postPreviews = postMetadata.map((post) => (
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