import {Container, Row, Col} from 'react-bootstrap';
import Carousel from "react-multi-carousel";
import "react-multi-carousel/lib/styles.css";
import javaLogo2 from "../public/img/java-Logo-2.png";
import spring3 from "../public/img/spring3.png";
import python from "../public/img/python.png";
import terraform from "../public/img/terraform.png";
import maven from "../public/img/maven.png";
import bash from '../public/img/bash.png';
import git from '../public/img/git.png';
import jenkins from '../public/img/jenkins.png';
import lambda from '../public/img/lambda.png';
import s3 from '../public/img/S3.png';
import route53 from '../public/img/route53.svg';
import cLogo from '../public/img/c.png';
import nodejsLogo from '../public/img/nodejs.png';
import typescriptLogo from '../public/img/typescript.webp';
import ec2Logo from '../public/img/ec2.svg';
import sqlLogo from '../public/img/sql.png';
import reactLogo from '../public/img/react.png';
import jsLogo from '../public/img/js.png';
import htmlLogo from '../public/img/html5.png';
import cssLogo from '../public/img/css.webp';
import dynatraceLogo from '../public/img/dynaLogo.png';
import iamLogo from '../public/img/iam.svg';
import cloudformationLogo from '../public/img/cloudformation.png';
import dockerLogo from '../public/img/docker.png';
import angularLogo from '../public/img/angular.webp';
import colorSharp from "../public/img/color-sharp.png"
import saaLogo from "../public/img/solutions_architect_associate.png";
import cPractitionerLogo3 from "../public/img/cloud_practitioner3.png";
import terraformAssociate from "../public/img/terraform_associate.png";
import eventbridge from "../public/img/eventbridge-logo.png";
import sqs from "../public/img/sqs-logo.png";
import vercel from "../public/img/vercel-logo.svg"
import tailwind from "../public/img/tailwind-logo.png"



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
          items: 6
        },
        desktop: {
          breakpoint: { max: 3000, min: 1024 },
          items: 4
        },
        tablet: {
          breakpoint: { max: 1024, min: 464 },
          items: 1
        },
        mobile: {
          breakpoint: { max: 464, min: 0 },
          items: 1
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
                                        <img src={javaLogo2.src} alt="Java" />
                                        <h5>Java</h5>
                                    </div>
                                    <div className="item">
                                        <img src={spring3.src} alt="Spring" />
                                        <h5>Spring</h5>
                                    </div>
                                    <div className="item">
                                        <img src={python.src} alt="Python" />
                                        <h5>Python</h5>
                                    </div>
                                    <div className="item">
                                        <img src={terraform.src} alt="Terraform" />
                                        <h5>Terraform</h5>
                                    </div>
                                    <div className="item">
                                        <img src={maven.src} alt="Maven" />
                                        <h5>Maven</h5>
                                    </div>
                                    <div className="item">
                                        <img src={git.src} alt="Git" />
                                        <h5>Git</h5>
                                    </div>
                                    <div className="item">
                                        <img src={jenkins.src} alt="Jenkins" />
                                        <h5>Jenkins</h5>
                                    </div>
                                    <div className="item">
                                        <img src={ec2Logo.src} alt="EC2" />
                                        <h5>EC2</h5>
                                    </div>
                                    <div className="item">
                                        <img src={lambda.src} alt="Lambda" />
                                        <h5>Lambda</h5>
                                    </div>
                                    <div className="item">
                                        <img src={s3.src} alt="S3" />
                                        <h5>S3</h5>
                                    </div>
                                    <div className="item">
                                        <img src={route53.src} alt="Route53" />
                                        <h5>Route53</h5>
                                    </div>
                                    <div className="item">
                                        <img src={bash.src} alt="Bash" />
                                        <h5>Bash</h5>
                                    </div>
                                </Carousel>
                            </Container>
                            <Container className='skill-row'>
                            <h4 id='skill-slider-skill-label'>Advanced</h4>
                                <Carousel responsive={responsive} infinite={true} className="skill-slider" >
                                    <div className="item">
                                        <img src={cLogo.src} alt="C" />
                                        <h5>C</h5>
                                    </div>
                                    <div className="item">
                                        <img src={nodejsLogo.src} alt="Nodejs" />
                                        <h5>Nodejs</h5>
                                    </div>
                                    <div className="item">
                                        <img src={typescriptLogo.src} alt="Typescript" />
                                        <h5>Typescript</h5>
                                    </div>
                                    <div className="item">
                                        <img src={eventbridge.src} alt="EventBridge" />
                                        <h5>EventBridge</h5>
                                    </div>
                                    <div className="item">
                                        <img src={sqs.src} alt="SQS" />
                                        <h5>SQS</h5>
                                    </div>
                                </Carousel>
                            </Container>
                            <Container className='skill-row'>
                            <h4 id='skill-slider-skill-label'>Intermediate</h4>
                                <Carousel responsive={responsive} infinite={true} className="skill-slider" >
                                    <div className="item">
                                        <img src={sqlLogo.src} alt="SQL" />
                                        <h5>SQL</h5>
                                    </div>
                                    <div className="item">
                                        <img src={reactLogo.src} alt="React" />
                                        <h5>React</h5>
                                    </div>
                                    <div className="item">
                                        <img src={jsLogo.src} alt="JavaScript" />
                                        <h5>JavaScript</h5>
                                    </div>
                                    <div className="item">
                                        <img src={htmlLogo.src} alt="HTML5" />
                                        <h5>HTML5</h5>
                                    </div>
                                    <div className="item">
                                        <img src={cssLogo.src} alt="CSS" />
                                        <h5>CSS</h5>
                                    </div>
                                    <div className="item">
                                        <img src={tailwind.src} alt="Tailwind" />
                                        <h5>Tailwind</h5>
                                    </div>
                                    <div className="item">
                                        <img className="invert" src="https://www.svgrepo.com/show/354113/nextjs-icon.svg" alt="Next.js" />
                                        <h5>Next.js</h5>
                                    </div>
                                    <div className="item">
                                        <img className="invert" src={vercel.src} alt="Vercel" />
                                        <h5>Vercel</h5>
                                    </div>
                                    <div className="item">
                                        <img src={dynatraceLogo.src} alt="DynaTrace" />
                                        <h5>DynaTrace</h5>
                                    </div>
                                    <div className="item">
                                        <img src={iamLogo.src} alt="IAM" />
                                        <h5>IAM</h5>
                                    </div>
                                    <div className="item">
                                        <img src={cloudformationLogo.src} alt="CloudFormation" />
                                        <h5>CloudFormation</h5>
                                    </div>
                                </Carousel>
                            </Container>
                            <Container className='skill-row'>
                            <h4 id='skill-slider-skill-label'>Novice</h4>
                                <Carousel responsive={responsive} infinite={true} className="skill-slider" >
                                    <div className="item">
                                        <img src={dockerLogo.src} alt="Docker" />
                                        <h5>Docker</h5>
                                    </div>
                                    <div className="item">
                                        <img src={angularLogo.src} alt="Angular" />
                                        <h5>Angular</h5>
                                    </div>
                                </Carousel>
                            </Container>
                            <Container className='skill-row'>
                            <h4 id='skill-slider-skill-label'>Certifications</h4>
                                <Carousel responsive={certifications} infinite={true} className="skill-slider" >
                                    <div className="certItem">
                                        <img src={saaLogo.src} alt="AWS Certified Solutions Architect Associate" />
                                    </div>
                                    <div className="certItem">
                                        <img src={cPractitionerLogo3.src} alt="AWS Certified Cloud Practitioner" />
                                    </div>
                                    <div className="certItem">
                                        <img src={terraformAssociate.src} alt="Hashicorp Terraform Associate" />
                                    </div>
                                </Carousel>
                            </Container>
                        </div>
                      </Col>
                  </Row>
              </Container>
              <img className="background-image-left" src={colorSharp.src} alt=""/>
              <img className="background-image-right" src={colorSharp.src} alt=""/>
          </section>
      )
}

export default Skills;