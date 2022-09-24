import { Col, Container, Tab, Row} from 'react-bootstrap';
import Nav from 'react-bootstrap/Nav';
import ProjectCard from './ProjectCard';
import discordImage from '../assets/img/discord_bot.png'
import testServerImage from '../assets/img/test_server.jpg'
import prepchefImage2 from '../assets/img/prepchef2.webp'
import portfolioLogo from '../assets/img/portfolio_logo.jpg'


function Projects() {

    const projects = [
        {
            title: "BoT_UP",
            description: "Used to automate dining court selection (when I was in college and ate at dining courts). The bot would automatically scrape the dining court websites each day for their food selection, then use machine learning (sklearn) to select which dining court I would choose based on the foods available. Afterwards, the selection was sent to a Discord server where it was broadcasted to my friends and I.",
            imgUrl: discordImage
        },
        {
            title: "Ternary Trie Test Server",
            description: "Used to help other students complete a project involving Ternary Tries in our Data Structures & Algorithms course. Using a client-server architecture, students were able to connect to my server and have their implementation compared against mine to check for correctness. 114 students used the application.",
            imgUrl: testServerImage
        },
        {
            title: "PrepChef",
            description: "Web application used to search for cooking recipes. Could filter by allergens, ingredients, etc. The backend was Java using Spring Boot with a MySQL relational database. The frontend was written in Vue.",
            imgUrl: prepchefImage2
        },
        {
            title: "My Portfolio",
            description: "This is a static web application. The frontend was constructed with React and Bootstrap. The domain is registered through Route53, and the static files are hosted on an S3 bucket with CloudFront as a CDN. Custom certificates are used to ensure a HTTPS connection is maintained. All of which is backed by Terraform - meaning the whole stack can be torn down and built up in minutes.",
            imgUrl: portfolioLogo
        }
    ];

    return (
        <section className="project">
            <Container>
                <Row>
                    <Col>
                      <h2 id="projects">Projects</h2>
                      <h4>Hover for more details</h4>
                      <Tab.Container id="project-tabs" defaultActiveKey="first">
                        <Nav variant="pills" className="nav-pills mb-5 justify-content-center align-items-center" id="pills-tab">
                            <Nav.Item>
                                <Nav.Link eventKey="first">BoT_UP</Nav.Link>
                            </Nav.Item>
                            <Nav.Item>
                                <Nav.Link eventKey="second">Ternary Trie Test Server</Nav.Link>
                            </Nav.Item>
                            <Nav.Item>
                                <Nav.Link eventKey="third">PrepChef</Nav.Link>
                            </Nav.Item>
                            <Nav.Item>
                                <Nav.Link eventKey="fourth">This site!</Nav.Link>
                            </Nav.Item>
                        </Nav>
                        <Tab.Content>
                            <Tab.Pane eventKey="first">
                                {
                                    <ProjectCard title={projects[0].title} description={projects[0].description} imgUrl={projects[0].imgUrl}/>
                                }
                            </Tab.Pane>
                            <Tab.Pane eventKey="second">
                                {
                                    <ProjectCard title={projects[1].title} description={projects[1].description} imgUrl={projects[1].imgUrl}/>
                                }
                            </Tab.Pane>
                            <Tab.Pane eventKey="third">
                                {
                                    <ProjectCard title={projects[2].title} description={projects[2].description} imgUrl={projects[2].imgUrl}/>
                                }
                            </Tab.Pane>
                            <Tab.Pane eventKey="fourth">
                                {
                                    <ProjectCard title={projects[3].title} description={projects[3].description} imgUrl={projects[3].imgUrl}/>
                                }
                            </Tab.Pane>
                        </Tab.Content>
                        </Tab.Container>
                    </Col>
                </Row>
            </Container>
            {/* <img className="background-image-right" src={colorSharp2}/> */}
        </section>
    )

}

export default Projects;