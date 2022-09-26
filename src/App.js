import './App.css';
import Navbar from "./components/Navbar"
import Banner from './components/Banner'
import Skills from './components/Skills'
import Projects from './components/Projects'
import Footer from './components/Footer'

function App() {
  return (
    <div className="App">
      <meta name="viewport" content="1024px"/>
        <Navbar></Navbar>
        <Banner></Banner>
        <Skills></Skills>
        <Projects></Projects>
        <Footer></Footer>
    </div>
  );
}

export default App;
