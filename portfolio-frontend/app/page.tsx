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
