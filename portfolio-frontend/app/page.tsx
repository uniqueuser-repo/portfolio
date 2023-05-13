'use client';
import Banner from './/Banner'
import Skills from './Skills'
import Projects from './/Projects'
import Navbar from './Navbar'
import Footer from './Footer'
import { SSRProvider } from 'react-bootstrap'
import Head from 'next/head';

export default function Home() {
  return (
    <SSRProvider>
      <div>
        <Head>
          <title>Andrew Orlowski</title>
          <meta name="description" content="Andrew Orlowski\'s website. Andrew Orlowski is a Software Engineer and ex-professional VALORANT player. Andrew Orlowski was born in 1999." />
        </Head>
        <Navbar></Navbar>
        <Banner></Banner>
        <Skills></Skills>
        <Projects></Projects>
        <Footer></Footer>
      </div>
    </SSRProvider>
  )
}