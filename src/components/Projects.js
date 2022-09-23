import { Col, Container, Tab, Row} from 'react-bootstrap';
import Nav from 'react-bootstrap/Nav';
import ProjectCard from './ProjectCard';
import colorSharp2 from '../assets/img/color-sharp2.png'
import projImg1 from '../assets/img/project-img1.png'
import discordImage from '../assets/img/discord_bot.png'


function Projects() {

    const projects = [
        {
            title: "BoT_UP",
            description: "Machine Learning Algorithm",
            imgUrl: discordImage
        }
    ];
    
    return (
        <section className="project" id="project">
            <Container>
                <Row>
                    <Col>
                      <h2>Projects</h2>
                      <h4>Hover for more details</h4>
                      <Tab.Container id="project-tabs" defaultActiveKey="first">
                        <Nav variant="pills" className="nav-pills mb-5 justify-content-center align-items-center" id="pills-tab">
                            <Nav.Item>
                                <Nav.Link eventKey="first">BoT_UP</Nav.Link>
                            </Nav.Item>
                            <Nav.Item>
                                <Nav.Link eventKey="second">Tab Two</Nav.Link>
                            </Nav.Item>
                            <Nav.Item>
                                <Nav.Link eventKey="third">
                                Tab Three
                                </Nav.Link>
                            </Nav.Item>
                        </Nav>
                        <Tab.Content>
                            <Tab.Pane eventKey="first">
                                <Row>
                                    {
                                        <ProjectCard title={projects[0].title} description={projects[0].description} imgUrl={projects[0].imgUrl}/>
                                    }
                                </Row>
                            </Tab.Pane>
                            <Tab.Pane eventKey="second">
                                <Row>
                                    Lorem Ipsum
                                </Row>
                            </Tab.Pane>
                            <Tab.Pane eventKey="third">
                                <Row>
                                    Lorem Ipsum
                                </Row>
                            </Tab.Pane>
                        </Tab.Content>
                        </Tab.Container>
                    </Col>
                </Row>
            </Container>
            <img className="background-image-right" src={colorSharp2}/>
        </section>
    )

}

export default Projects;