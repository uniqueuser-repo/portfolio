import NavBar from "../Navbar";
import Footer from "../Footer";

function Resume() {
  return (
    <>
      <NavBar />
      <p id="resume-pdf" style={{ display: 'flex', justifyContent: 'center' }}>
        <iframe
          title="Andrew Orlowski Resume"
          style={{ width: '1000px', height: '1135px' }}
          src={'Andrew_Orlowski_Resume.pdf#toolbar=0&navpanes=0'}
        />
      </p>
      <Footer />
    </>
  );
}
export default Resume;

export const metadata = {
  title: "Resume",
  description: "Andrew Orlowski's Resume. Andrew is a Software Engineer and ex-professional VALORANT player."
};