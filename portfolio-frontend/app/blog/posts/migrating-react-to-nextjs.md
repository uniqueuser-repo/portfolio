---
title: "Efficient Migration Guide: Transitioning from React to Next.js 13"
subtitle: "Unlocking SEO Potential: Why React SPAs (Single Page Applications) Fall Short"
date: "05/11/2023"
slug: "migrating-react-to-nextjs"
---

Not exactly sure why, but recently I've been super intent on spending my time doing things that are productive. I, like the average gamer and very stereotypical Computer Science graduate, waste away a ton of time surfing Reddit and YouTube or playing video games.

The thing I fixated on this time around (starting about five days ago) was trying to create a blog that would actually show up on search engines like google. If you search for my page now, you can't even find it:

![site not showing in Google results](/blog_images/site-not-showing-in-google-min.png)

In this blog post, we'll explore the challenges faced by React Single Page Applications (SPAs) in terms of SEO optimization and how to overcome them by transitioning to Nextjs13. Discover effective strategies to boost the search engine visibility of your blog and increase organic traffic.

## The Challenge of React SPAs for SEO

During my research, I discovered that React Single Page Applications (SPAs) [may not be the best choice](https://ahrefs.com/blog/react-seo/). As someone with a background in Java and Spring development, this was surprising. However, further investigation revealed the underlying reasons.

When you visit a website, say [nytimes.com](nytimes.com), and visit an article, say [this one, which is an article about crossword puzzles titled "Time to Focus on Oneself"](https://www.nytimes.com/2023/05/11/crosswords/daily-puzzle-2023-05-12.html),  you'll notice the presence of forward slashes ("/") in the URL. It resembles a path.

![url looks like a path](/blog_images/looks-like-a-path-min.png)

If nytimes.com were a React SPA, the path would appear in your browser's URL bar, and you as a user might think it's a distinct URL, but it's not. Instead, nytimes.com would provide your browser with the necessary tools to simulate the existence of that page. By clicking on an article from the landing page, JavaScript would modify the URL in your browser, which leads you to see the `/`'s, and JavaScript would execute to retrieve the necessary information of the article, but you never truly left `nytimes.com`. 

Essentially, these pages are virtual and not indexed by Google's crawler. When Google visits your React SPA website, it sees only a single URL (e.g. nytimes.com, in this hypothetical where nytimes.com is a React SPA) and doesn't index the "fake" URLs. This can have a negative impact on SEO. Imagine if you were talking to a friend later and tried to search google for a New York Times article, and only the landing page showed up in the result:

![only landing page in results](/blog_images/searching-for-time-to-focus-on-oneself-min.png)

To improve SEO, it's crucial to consider the limitations of React SPAs and their impact on search engine indexing and ranking.

## The Solution: Transitioning to Next.js 13 from React

To address the issue of non-existent paths in React, we can make them genuinely exist rather than relying on a landing page's illusion. Is it possible to achieve this with React? Absolutely! The recommended solution involves leveraging a framework called [Nextjs.](https://nextjs.org/)

![nextjs logo](https://www.svgrepo.com/show/354113/nextjs-icon.svg)

Next.js helps us improve SEO by simplifying the process of creating actual server-backed paths while still allowing certain paths to function as "fake" routes that are effectively maintained by React.

In Next.js, we have the distinction between [client components and server components](https://nextjs.org/docs/getting-started/react-essentials). Client components execute on the browser, while server components run on the server. By utilizing server components, we can ensure that specific paths are real, and the server component generates the complete HTML and JS when requested. While a comprehensive exploration of Next.js is beyond the scope of this discussion, this provides a brief overview.

## How do I migrate my create-react-app to Nextjs?

First, we should take a look at the landing page before the migration.

![old website screenshot](/blog_images/old-website-min.png)

Now, it looks pretty much the same. The only difference visually is that there's now a "Blog" option in the navbar at the top. The big difference under the hood is that it's on Nextjs13.

So what steps did I take to make this change?


## Create a next application

I started by using `npx create-next-app@latest` in terminal (I use the WSL2 - Windows Subsystem for Linux) to create a brand new (and empty) Nextjs project. Check out the image below and follow along.

![output of npx create-next-app](/blog_images/create-next-app-min.png)

If you're particularly attentive, you might notice something in that image. Don't worry, though, I don't use that password for anything else. You can't do anything with it unless you're at my desktop and it's already logged in and you open an Ubuntu terminal. 😅

Initially, my React application consisted of a single-page SPA acting as a landing page. Clicking the "resume" button in the navbar would simulate navigation to the `/resume` path, resembling a separate page. Transitioning between React components was straightforward. I duplicated all my components into the `/app` folder of the create-next-app project and added the `'use client';` statement at the top of each component.

![screenshot of 'use client' at top of component](/blog_images/use-client-min.png)

By default, Next.js assumes components are server-side components and renders them on the server, returning HTML to the client. Us labelling all of the componenets with `'use client';` negates that. This suffices for now, but my goal is to transform the `/resume` path into an actual page indexed by search engines. Eventually, we'll remove the `'use client'` statement.

There are slight differences in the files responsible for rendering HTML and JavaScript when a page is requested. In React, this is typically done in `index.js`. However, within the `app/` directory, you'll find `page.tsx`, which serves as the rendered output when someone visits the website. Place your landing page React component in this file, temporarily excluding any switches or routers, and display only the landing page.

old index.js:
![old index.js file](/blog_images/old-page-min.png) 

new page.tsx (note that the `App` component was removed and flattened - that's not relevant though):
![migrated page.tsx file](/blog_images/migrated-page-min.png)

Ensure you wrap your client application component in an `<SSRProvider>`. This is a magic element that Nextjs 13 provides to us in order to ensure that auto generated IDs are consistent between the client and serve. Throughout the process, I alternated between starting the server using `npm run dev`, which alerted me about missing dependencies and suggested the specific ones needed. I resolved this by running `npm i {missing-dependency}` until the server successfully launched. Once it did, I observed plaintext HTML displaying the content of my components, albeit without the CSS styling.

## Porting the styling

During the transition to Next.js, I noticed that most of the elements on my old website inherited CSS styling from Bootstrap libraries, specifically through .scss files.

![table element with bootstrap styling](/blog_images/inheriting-bootstrap-css-min.png)

In Next.js, the equivalent functionality is achieved through the globals.css or globals.scss file located in the app/ directory. Initially, I used globals.css, but upon discovering that Bootstrap files were in .scss format, I changed the file extension. Fortunately, this adjustment didn't cause any issues except for a warning in VSCode related to Tailwind CSS.

![vscode error on line with tailwind annotation](/blog_images/tailwind-error-min.png)

To incorporate the stylesheets used by my elements, I utilized @import annotations within the stylesheet. Additionally, it's important to import the globals.scss file in the app/layout.tsx file. Voila, my page looked great again!

![import annotations in stylesheet](/blog_images/import-annotation-min.png)

## Migrating React Routes to NextJS

With React, you probably have something that looks kind of like this somewhere in your code:

```
<BrowserRouter>
    <Navbar/>
    <Switch>
        <Route path="/resume" component={Resume}/>
        <Route path="/" component={App}/>
    </Switch>
    <Footer/>
</BrowserRouter>
```

In my case, the `/` path corresponds to the landing page, while `/resume` represents the resume page. However, in a React SPA, only the `/` page actually exists. The webpage creates the illusion of `/resume` being a real page through the browser and React handling.

For SEO purposes, we want `/resume` to be a legitimate page that search engines like Google can crawl. Therefore, the React router is not suitable in this scenario. If you haven't done so already, remove the router and keep only the non-router components:

```
<Navbar/>
<App/>
<Footer/>
```

## Add server-side routes in Nextjs

To reintroduce the routes we removed earlier, we can leverage Next.js' folder-based route convention. Let's take the example of the `/resume` path. First, create a folder named resume under the app directory. Inside the resume folder, add a `page.tsx` file. This `page.tsx` file will be rendered when a client visits the `/resume` path.

![hierarchy of project and resume folder](/blog_images/resume-page-min.png)

Within the `page.tsx` file, include the component(s) that were previously responsible for rendering our resume page. Ensure that this page does not include the `'use client';` statement. It's crucial that the server handles the rendering to ensure visibility on search engines.

Repeat this process for each route in our application. By following these steps, we have successfully migrated our entire application to Next.js 13. It's worth noting that dynamic routes require a more intricate approach, which will be covered in a future post.

## How do I handle deployments?

When it came to hosting my old site, I relied on S3 and CloudFront. Any API calls were directed to a Lambda through an API Gateway. However, implementing a similar setup for Next.js seemed highly impractical. Each server-side component would require its own Lambda, making it more feasible to use services like Fargate, ECS, or EC2 to host the entire app. Unfortunately, this approach seemed cumbersome.

The best solution is to opt for a service that abstracts away the complexities and handles the hosting for you. Here are three options:

# 1. [Vercel](https://vercel.com/)

 Vercel, the company behind Next.js, offers a platform that stays up to date with the latest releases and supports the newest features. The big downside is that their pricing is [outright theft](https://service-markup.vercel.app/) when your throughput is that of a real company. When you're sitting comfortably in the free-tier, it's incredible. For that reason, I chose Vercel.

# 2. [AWS Amplify](https://aws.amazon.com/amplify/)

I'm a massive fan of AWS. I love it. AWS makes the serverless experience incredible, and I love serverless since I build projects that are low volume (understandably so.) Did you know that the Lambda free-tier (which is indefinite, by the way - it doesn't expire like other free tier services) offers [1,000,000 free requests and 400,000 GB-hours per month](https://aws.amazon.com/lambda/pricing/)?

AWS Amplify is far and away a more cost-effective alternative to Vercel. That being said, AWS Amplify isn't a service whose sole purpose is to support Nextjs. AWS Amplify is often behind on features (as of now, they "support" Nextjs13, but don't support Nextjs13 functionality such as middleware). Further, there are a bunch of horror stories about trying to host Nextjs on AWS Amplify on [Reddit](https://www.reddit.com/r/nextjs/comments/uamqbl/beware_of_nextjs_on_aws_amplify/). As the icing on the cake, Amplify doesn't exactly look well supported. As I write this, one of their [repositories has nearly 600 open issues](https://github.com/aws-amplify/amplify-cli).

![600 open issues screenshot](/blog_images/600-issues-min.png)

If you're a company that sees high volume, it might be worth a shot.

# 3. [Serverless framework](https://github.com/serverless-nextjs/serverless-next.js)

I stumbled upon this option initially, and figured it was the way to go. It boasts about being able to deploy your application to CloudFront, generate Lambdas, etc automatically. Unfortunately, it looks like the maintainers have dropped this project entirely. It hasn't received updates in more than a year and doesn't support many features of Nextjs13. Open issues don't get any love either. I tried using this framework for about two hours but deployments were failing and there was no clear reason as to why, so I gave up. You might have more success.

In any case, choose the hosting solution that best suits your needs and volume requirements.

## Fin

Well, that's all for the first blog post I've ever made. Hopefully, this was a bit of help to you. I'll tackle things such as dynamic routes and pointing my Route53 domain towards Vercel in separate blogs. If you have issues, feel free to shoot me an email at andyorlowskia@gmail.com - if I can help, I will.