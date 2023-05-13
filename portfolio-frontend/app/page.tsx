"use client"
import Banner from './/Banner'
import Skills from './Skills'
import Projects from './/Projects'
import Navbar from './Navbar'
import Footer from './Footer'
import { SSRProvider } from 'react-bootstrap'

export default function Home() {
  return (
    <SSRProvider>
      <div>
        <Navbar></Navbar>
        <Banner></Banner>
        <Skills></Skills>
        <Projects></Projects>
        <Footer></Footer>
      </div>
    </SSRProvider>
  )
}

export const metadata = {
  title: 'Andrew Orlowski',
  description: 'Andrew Orlowski\'s website. Andrew Orlowski is a Software Engineer and ex-professional VALORANT player. Andrew Orlowski was born in 1999.',
}
