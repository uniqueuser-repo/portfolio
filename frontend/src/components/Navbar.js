import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import {  useState, useEffect } from 'react';
import navIcon1 from '../assets/img/nav-icon1.svg'
import navIcon2 from '../assets/img/Octicons-mark-github.svg'
import VisitorCounter from './VisitorCounter.js'
import { useHistory } from "react-router-dom";
import { withRouter } from "react-router";

function NavBar() {
  const [activeLink, setActiveLink] = useState('home');
  const [scrolled, setScrolled] = useState(false);
  const history = useHistory();

  const onUpdateActiveLink = (value) => {
      setActiveLink(value);

      if (value === 'resume') {
        history.push("/resume");
        window.scrollTo(0, 0);
      } else {
        history.push("/");
      }
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
  
  return (
    <Navbar bg="dark" expand="lg" className={scrolled ? "scrolled":""}>
      <Container>
        <Navbar.Toggle aria-controls="basic-navbar-nav"> 
            <span className="navbar-toggler-icon"></span>
        </Navbar.Toggle>
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            <Nav.Link href="#home" className={activeLink === 'home' ?  'active navbar-link' : 'navbar-link'} onClick={() => onUpdateActiveLink('home')}>Home</Nav.Link>
            <Nav.Link href="#skills" className={activeLink === 'skills' ?  'active navbar-link' : 'navbar-link'} onClick={() => onUpdateActiveLink('skills')}>Skills</Nav.Link>
            <Nav.Link href="#projects" className={activeLink === 'projects' ?  'active navbar-link' : 'navbar-link'} onClick={() => onUpdateActiveLink('projects')}>Projects</Nav.Link>
            <Nav.Link href="#resume" className={activeLink === 'resume' ?  'active navbar-link' : 'navbar-link'} onClick={() => onUpdateActiveLink('resume')}>Resume</Nav.Link>
            <Nav.Link href="https://aorlowski.com" className={activeLink === 'aorlowski' ?  'active navbar-link' : 'navbar-link'} onClick={() => onUpdateActiveLink('aorlowski')}>Go Back</Nav.Link>
          </Nav>
          <VisitorCounter/>
          <span className="navbar-text"> 
            <div className="social-icon">
                <a href="https://linkedin.com/in/andrew-orlowski-08a035175/" target="_blank" rel="noreferrer noopener"><img src={navIcon1} title="LinkedIn" alt="LinkedIn"/> </a>
                <a href="https://github.com/uniqueuser-repo" target="_blank" rel="noreferrer noopener"><img src={navIcon2} id="must-invert" title="GitHub" alt="GitHub"/> </a>
            </div>
          </span>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
}

export default withRouter(NavBar);