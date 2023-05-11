/** @type {import('next').NextConfig} */
const nextConfig = {
    sassOptions: {
        includePaths: ['.'],
    },
    images: {
      unoptimized: true,
    },
}



module.exports = nextConfig
