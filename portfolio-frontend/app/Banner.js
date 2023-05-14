"use client"
import { useState, useEffect } from 'react';
import {Container, Row, Col } from "react-bootstrap";
import Image from 'next/image'

function Banner() {
    const [loopNum, setLoopNum] = useState(0);
    const [isDeleting, setIsDeleting] = useState(false);
    const toRotate = [ "Engineer", "Developer" ]
    const [text, setText] = useState('');
    const [delta, setDelta] = useState(150);

    const tick = () => {
        let i = loopNum %  toRotate.length;
        let fullText = toRotate[i]
        let updatedText = isDeleting ? fullText.substring(0, text.length - 1) : fullText.substring(0, text.length + 1);

        setDelta(150);
        setText(updatedText);

        if (!isDeleting && updatedText === fullText) {
            setIsDeleting(true);
            setDelta(1250);
        } else if (isDeleting && updatedText === '') {
            setIsDeleting(false);
            setLoopNum(loopNum + 1);
            setDelta(1250);
        }
    }

    useEffect(() => {
        let ticker = setInterval(() => {
            tick();
        }, delta)

        return () => {clearInterval(ticker)}
    })

    return (
        <section className="banner" id="home">
            <Container>
                <Row className="align-items-center">
                    <Col xs={12} md={6} xl={7}>
                        <span className="tagline">Welcome to my Portfolio!</span>
                        <h1>{`Hi, I'm Andrew!`}</h1>
                        <h1><span className="wrap">{text}</span></h1>
                        <p>A software engineer highly proficient in Java, Spring Boot, and AWS cloud services. Additionally, I am proficient in Python, Node.js, and various other languages and frameworks. I have hands-on experience in DevOps and a strong understanding of Infrastructure as Code using Terraform.</p>
                    </Col>
                    <Col xs={12} md={6} xl={5}>
                        <Image src="/img/computer-icon.png" alt="Floating Computer" width={512} height={512} />
                    </Col>
                </Row>
            </Container>
        </section>
    )
}

export default Banner;