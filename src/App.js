import './App.css';
import Navbar from "./components/Navbar"
import Banner from './components/Banner'
import Skills from './components/Skills'
import Projects from './components/Projects'

function App() {
  return (
    <div className="App">
      <Navbar></Navbar>
      <Banner></Banner>
      <Skills></Skills>
      <Projects></Projects>
    </div>
  );
}

export default App;
