import React from 'react';
import { MDBFooter, MDBContainer, MDBRow, MDBCol, MDBIcon } from 'mdb-react-ui-kit';

export default function App() {
  return (
    <MDBFooter bgColor='dark' className='text-center text-lg-start text-muted' id="footerBox">

      <section className=''>
        <MDBContainer className='text-center text-md-start mt-5'>
          <MDBRow className='mt-3'>
            <MDBCol md="3" lg="4" xl="3" className='mx-auto mb-4'>
              <h6  className='text-uppercase fw-bold mb-4 footer-top-margin'>
                <MDBIcon icon="gem" className="me-3" />
                Andrew Orlowski
              </h6>
              <p>
                Software engineer with substantial experience with backend development, DevOps, and the Cloud. High interest in frontend languages and frameworks.
              </p>
            </MDBCol>


            <MDBCol md="4" lg="3" xl="3" className='mx-auto mb-md-0 mb-4'>
              <h6  className='text-uppercase fw-bold mb-4 footer-top-margin move-contact-right'>Contact</h6>
              <p>
                <MDBIcon icon="home" className="me-2 me-align" />
                &nbsp;&nbsp;Urbana, IL
              </p>
              <p>
                <MDBIcon icon="envelope" className="me-3 me-align" />
                &nbsp;andyorlowskia@gmail.com
              </p>
              <p>
                <MDBIcon icon="phone" className="me-3 me-align" /> +1 (847) - 529 - 2633
              </p>
            </MDBCol>
          </MDBRow>
        </MDBContainer>
      </section>

      <div className='text-center p-4' style={{ backgroundColor: 'rgba(0, 0, 0, 0.05)' }}>
        © 2022 Copyright
        <a id="CopyrightName" className='text-reset fw-bold' href='https://aorlowski.com'>
          Andrew Orlowski
        </a>
      </div>
    </MDBFooter>
  );
}