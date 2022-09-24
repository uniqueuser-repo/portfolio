import {Container, Row, Col} from 'react-bootstrap';
import Carousel from "react-multi-carousel";
import "react-multi-carousel/lib/styles.css";
import javaLogo2 from "../assets/img/java-Logo-2.png";
import spring3 from "../assets/img/spring3.png";
import python from "../assets/img/python.png";
import terraform from "../assets/img/terraform.png";
import maven from "../assets/img/maven.png";
import bash from '../assets/img/bash.png';
import git from '../assets/img/git.png';
import jenkins from '../assets/img/jenkins.png';
import lambda from '../assets/img/lambda.png';
import s3 from '../assets/img/S3.png';
import route53 from '../assets/img/route53.svg';
import cLogo from '../assets/img/c.png';
import nodejsLogo from '../assets/img/nodejs.png';
import elasticacheLogo from '../assets/img/ElastiCache.png';
import typescriptLogo from '../assets/img/typescript.webp';
import ec2Logo from '../assets/img/ec2.svg';
import sqlLogo from '../assets/img/sql.png';
import reactLogo from '../assets/img/react.png';
import jsLogo from '../assets/img/js.png';
import htmlLogo from '../assets/img/html5.png';
import cssLogo from '../assets/img/css.webp';
import dynatraceLogo from '../assets/img/dynaLogo.png';
import iamLogo from '../assets/img/iam.svg';
import cloudformationLogo from '../assets/img/cloudformation.png';
import dockerLogo from '../assets/img/docker.png';
import angularLogo from '../assets/img/angular.webp';
import colorSharp from "../assets/img/color-sharp.png"
import saaLogo from "../assets/img/solutions_architect_associate.png";
import cPractitionerLogo3 from "../assets/img/cloud_practitioner3.png";
import terraformAssociate from "../assets/img/terraform_associate.png"



function Skills() {
    const responsive = {
        superLargeDesktop: {
          breakpoint: { max: 4000, min: 3000 },
          items: 10
        },
        desktop: {
          breakpoint: { max: 3000, min: 1024 },
          items: 6
        },
        tablet: {
          breakpoint: { max: 1024, min: 464 },
          items: 2
        },
        mobile: {
          breakpoint: { max: 464, min: 0 },
          items: 1
        }
      };

      const certifications = {
        superLargeDesktop: {
          breakpoint: { max: 4000, min: 3000 },
          items: 7
        },
        desktop: {
          breakpoint: { max: 3000, min: 1024 },
          items: 6
        },
        tablet: {
          breakpoint: { max: 1024, min: 464 },
          items: 4
        },
        mobile: {
          breakpoint: { max: 464, min: 0 },
          items: 3
        }
      };

      

      return (
          <section className="skills" id="skills">
              <Container>
                  <Row>
                      <Col>
                        <div className="skill-bx">
                            <h2>
                                Skills
                            </h2>
                            <Container className='skill-row'>
                            <h4 id='skill-slider-skill-label'>Expert</h4>
                                <Carousel responsive={responsive} infinite={true} className="skill-slider" >
                                    <div className="item">
                                        <img src={javaLogo2} alt="Java" />
                                        <h5>Java</h5>
                                    </div>
                                    <div className="item">
                                        <img src={spring3} alt="Spring" />
                                        <h5>Spring</h5>
                                    </div>
                                    <div className="item">
                                        <img src={python} alt="Python" />
                                        <h5>Python</h5>
                                    </div>
                                    <div className="item">
                                        <img src={terraform} alt="Terraform" />
                                        <h5>Terraform</h5>
                                    </div>
                                    <div className="item">
                                        <img src={maven} alt="Maven" />
                                        <h5>Maven</h5>
                                    </div>
                                    <div className="item">
                                        <img src={git} alt="Git" />
                                        <h5>Git</h5>
                                    </div>
                                    <div className="item">
                                        <img src={jenkins} alt="Jenkins" />
                                        <h5>Jenkins</h5>
                                    </div>
                                    <div className="item">
                                        <img src={ec2Logo} alt="EC2" />
                                        <h5>EC2</h5>
                                    </div>
                                    <div className="item">
                                        <img src={lambda} alt="Lambda" />
                                        <h5>Lambda</h5>
                                    </div>
                                    <div className="item">
                                        <img src={s3} alt="S3" />
                                        <h5>S3</h5>
                                    </div>
                                    <div className="item">
                                        <img src={route53} alt="Route53" />
                                        <h5>Route53</h5>
                                    </div>
                                    <div className="item">
                                        <img src={bash} alt="Bash" />
                                        <h5>Bash</h5>
                                    </div>
                                </Carousel>
                            </Container>
                            <Container className='skill-row'>
                            <h4 id='skill-slider-skill-label'>Advanced</h4>
                                <Carousel responsive={responsive} infinite={true} className="skill-slider" >
                                    <div className="item">
                                        <img src={cLogo} alt="C" />
                                        <h5>C</h5>
                                    </div>
                                    <div className="item">
                                        <img src={typescriptLogo} alt="Typescript" />
                                        <h5>Typescript</h5>
                                    </div>
                                    <div className="item">
                                        <img src={nodejsLogo} alt="Nodejs" />
                                        <h5>Nodejs</h5>
                                    </div>
                                    <div className="item">
                                        <img src={elasticacheLogo} alt="ElastiCache" />
                                        <h5>ElastiCache</h5>
                                    </div>
                                </Carousel>
                            </Container>
                            <Container className='skill-row'>
                            <h4 id='skill-slider-skill-label'>Intermediate</h4>
                                <Carousel responsive={responsive} infinite={true} className="skill-slider" >
                                    <div className="item">
                                        <img src={sqlLogo} alt="SQL" />
                                        <h5>SQL</h5>
                                    </div>
                                    <div className="item">
                                        <img src={reactLogo} alt="React" />
                                        <h5>React</h5>
                                    </div>
                                    <div className="item">
                                        <img src={jsLogo} alt="JavaScript" />
                                        <h5>JavaScript</h5>
                                    </div>
                                    <div className="item">
                                        <img src={htmlLogo} alt="HTML5" />
                                        <h5>HTML5</h5>
                                    </div>
                                    <div className="item">
                                        <img src={cssLogo} alt="CSS" />
                                        <h5>CSS</h5>
                                    </div>
                                    <div className="item">
                                        <img src={dynatraceLogo} alt="DynaTrace" />
                                        <h5>DynaTrace</h5>
                                    </div>
                                    <div className="item">
                                        <img src={iamLogo} alt="IAM" />
                                        <h5>IAM</h5>
                                    </div>
                                    <div className="item">
                                        <img src={cloudformationLogo} alt="CloudFormation" />
                                        <h5>CloudFormation</h5>
                                    </div>
                                </Carousel>
                            </Container>
                            <Container className='skill-row'>
                            <h4 id='skill-slider-skill-label'>Novice</h4>
                                <Carousel responsive={responsive} infinite={true} className="skill-slider" >
                                    <div className="item">
                                        <img src={dockerLogo} alt="Docker" />
                                        <h5>Docker</h5>
                                    </div>
                                    <div className="item">
                                        <img src={angularLogo} alt="Angular" />
                                        <h5>Angular</h5>
                                    </div>
                                </Carousel>
                            </Container>
                            <Container className='skill-row'>
                            <h4 id='skill-slider-skill-label'>Certifications</h4>
                                <Carousel responsive={certifications} infinite={true} className="skill-slider" >
                                    <div className="certItem">
                                        <img src={saaLogo} alt="AWS Certified Solutions Architect Associate" />
                                    </div>
                                    <div className="certItem">
                                        <img src={cPractitionerLogo3} alt="AWS Certified Cloud Practitioner" />
                                    </div>
                                    <div className="certItem">
                                        <img src={terraformAssociate} alt="Hashicorp Terraform Associate" />
                                    </div>
                                </Carousel>
                            </Container>
                        </div>
                      </Col>
                  </Row>
              </Container>
              <img className="background-image-left" src={colorSharp} alt=""/>
              <img className="background-image-right" src={colorSharp} alt=""/>
          </section>
      )
}

export default Skills;