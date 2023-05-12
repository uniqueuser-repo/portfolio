
### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.


### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.\
Your app is ready to be deployed!

### Getting Started with Terraform

To use this, your domain must be hosted on Route53 and you must use Vercel to deploy your Next.js13 application. `terraform apply` will spin up everything except the hosted zone and the Vercel component. You need to deploy these yourself and specify values for these dependencies in the `locals.tf` file.

1. vercel_domain_str
2. vercel_dns_ip_str
3. hosted_zone_id
4. root_domain_str = "aorlowski.com"
5. subdomain_str = "www.aorlowski.com"
6. all_subdomain_str = "*.aorlowski.com"

If you choose to delete some of the domain locals, pay attention to those which you delete and make sure that their usages are deleted or updated as well.

## www.aorlowski.com and aorlowski.com
Requests to these webpages are forwarded to a Vercel deployment which is responsible for rendering the page you see.

## api.aorlowski.com
Requests to this webpage are forwarded to API Gateway which forwards your request to a Lambda that processes it.

## images.aorlowski.com
Requests to this webpage are forwarded to a Cloudfront distribution which caches images from an S3 bucket.

## old.aorlowski.com
Requests to this webpage are forwarded to a Cloudfront distribution whose origin is an S3 bucket for static website hosting. This webpage is the webpage before I made the transition from a React SPA to a Next.js 13 application.