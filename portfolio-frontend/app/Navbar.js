'use client';

import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import {  useState, useEffect } from 'react';
import VisitorCounter from './VisitorCounter.js'
import  { useRouter } from 'next/navigation';
import { usePathname } from 'next/navigation';

function NavBar() {
  const pathname = usePathname();
  const [activeLink, setActiveLink] = useState(pathname === "/" ? 'home' : pathname.substring(1));
  const [scrolled, setScrolled] = useState(false);


  const onUpdateActiveLink = (value) => {
    console.log("pathname is " + pathname);
    setActiveLink(value);
  }

  useEffect(() => {
      const onScroll = () => {
          if (window.scrollY > 50) {
              setScrolled(true);
          } else {
              setScrolled(false);
          }
      }

      window.addEventListener("scroll", onScroll);

      return () => window.removeEventListener("scroll",  onScroll)
  })
  
  let toDisplaySkills = 'block';
  let toDisplayProjects = 'block';
  let toDisplayResume = 'block';
  let toDisplayBlog = 'block';
  if (pathname == '/resume') {
    toDisplayResume = 'none';
    toDisplayProjects = 'none';
    toDisplaySkills = 'none';
  } else if (pathname == '/blog') {
    toDisplayProjects = 'none';
    toDisplaySkills = 'none';
    toDisplayBlog = 'none';
  } else if (pathname.startsWith("/blog/")) {
    toDisplayProjects = 'none';
    toDisplaySkills = 'none';
  }

  return (
    <Navbar bg="dark" expand="lg" className={scrolled ? "scrolled" : ""}>
      <Container className="">
        <Navbar.Toggle aria-controls="basic-navbar-nav"> 
            <span className="navbar-toggler-icon"></span>
        </Navbar.Toggle>
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            <Nav.Link href="/" className={activeLink === 'home' ?  'active navbar-link' : 'navbar-link'} onClick={() => onUpdateActiveLink('home')}>Home</Nav.Link>
            <Nav.Link href="#skills" className={activeLink === 'skills' ?  'active navbar-link' : 'navbar-link'} style={{display: toDisplaySkills}} onClick={() => onUpdateActiveLink('skills')}>Skills</Nav.Link>
            <Nav.Link href="#projects" className={activeLink === 'projects' ?  'active navbar-link' : 'navbar-link'} style={{display: toDisplayProjects}} onClick={() => onUpdateActiveLink('projects')}>Projects</Nav.Link>
            <Nav.Link href="/resume" className={activeLink === 'resume' ?  'active navbar-link' : 'navbar-link'} style={{display: toDisplayResume}} onClick={() => onUpdateActiveLink('resume')}>Resume</Nav.Link>
            <Nav.Link href="/blog" className={activeLink === 'blog' ?  'active navbar-link' : 'navbar-link'} style={{display: toDisplayBlog}} onClick={() => onUpdateActiveLink('blog')}>Blog</Nav.Link>
            <Nav.Link href="https://old.aorlowski.com" className={activeLink === 'aorlowski' ?  'active navbar-link' : 'navbar-link'} onClick={() => onUpdateActiveLink('aorlowski')}>Old Site</Nav.Link>
          </Nav>
          <VisitorCounter/>
          <span className="navbar-text"> 
            <div className="social-icon">
                <a href="https://linkedin.com/in/andrew-orlowski-08a035175/" target="_blank" rel="noreferrer noopener"><img src='/img/nav-icon1.svg' title="LinkedIn" alt="LinkedIn"/> </a>
                <a href="https://github.com/uniqueuser-repo" target="_blank" rel="noreferrer noopener"><img src='/img/Octicons-mark-github.svg' id="must-invert" title="GitHub" alt="GitHub"/> </a>
            </div>
          </span>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
}

export default NavBar;