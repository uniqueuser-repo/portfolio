import Navbar from "./Navbar"
import Banner from './/Banner'
import Skills from './Skills'
import Projects from './/Projects'
import Footer from './Footer'

function MainPage() {

    return (
        <div>
            <Navbar></Navbar>
            <Banner></Banner>
            <Skills></Skills>
            <Projects></Projects>
            <Footer></Footer>
        </div>
    )
}

export default MainPage;