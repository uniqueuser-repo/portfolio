"use client"
import Banner from './/Banner'
import Skills from './Skills'
import Projects from './/Projects'
import Navbar from './Navbar'

export default function Home() {
  return (
    <div>
      <Navbar></Navbar>
      <Banner></Banner>
      <Skills></Skills>
      <Projects></Projects>
    </div>
  )
}
