import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import reportWebVitals from './reportWebVitals';
import "bootstrap/dist/css/bootstrap.min.css";
import 'mdbreact/dist/css/mdb.css';
import '@fortawesome/fontawesome-free/css/all.min.css';
import {
  BrowserRouter,
  Switch,
  Route,
} from "react-router-dom";
import Resume from './components/Resume';
import Navbar from "./components/Navbar";
import Footer from "./components/Footer";

// Function to handle the click event of the popup button
function handlePopupClick() {
  document.getElementById('popup').style.display = 'none'; // Hide the popup
}

// Render the popup component

const Popup = () => (
  <div id="popup" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', position: 'fixed', top: 0, left: 0, width: '100%', height: '100%', background: 'rgba(0, 0, 0, 0.5)', zIndex: 999 }}>
    <div style={{ background: '#fff', padding: '20px', borderRadius: '5px', textAlign: 'center', maxWidth: '30%'}}>
      <h2 style={{ color: '#000' }}>This is my old site.</h2>
      <p style={{ color: '#000' }}>The site you see here is a React SPA (single page application) rather than the Next.js framework the new version is running on, which I completed migration of on 05/11/2023. This page won't receive any updates.</p>
      <button onClick={handlePopupClick} style={{ textDecoration: 'underline' }}>Check out the site</button>
    </div>
  </div>
);

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <BrowserRouter>
      <Navbar></Navbar>
      <Switch>
        <Route path="/resume" component={Resume}/>
        <Route path="/" component={App}/>
      </Switch>
      <Footer></Footer>
      <Popup /> {/* Render the popup component */}
    </BrowserRouter>
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();