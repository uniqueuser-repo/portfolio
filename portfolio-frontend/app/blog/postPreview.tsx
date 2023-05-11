import Link from "next/link";
import { PostMetadata } from "./PostMetadata";

const PostPreview = (props: PostMetadata) => {
  return (
    <div
      className="border border-slate-300 p-4 rounded-md shadow-sm bg-sky-900 
      hover:transform hover:scale-105 transition duration-300"
    >
      <p className="text-sm text-gray-300">{props.date}</p>

      <Link href={`/blog/${props.slug}`} className="">
        <h2 className="text-gray-300 hover:underline decoration-violet-800 mb-4 ">{props.title}</h2>
      </Link>
      <p className="text-gray-300">{props.subtitle}</p>
    </div>
  );
};

export default PostPreview;