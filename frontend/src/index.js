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
import Link from "next/link";
const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <BrowserRouter>
      <Navbar></Navbar>
        {/* <Route path="/resume" component={Resume}/>
        <Route path="/" component={App}/> */}

        <Link href="/resume"/>
        <Link href="/"/>
      <Footer></Footer>
    </BrowserRouter>
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
