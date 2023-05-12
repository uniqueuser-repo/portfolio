import AndyResume from '../assets/Andrew_Orlowski_Resume.pdf';

function Resume() {
    return (
        <p id="resume-pdf" align="center">
            <iframe
                title="Andrew Orlowski Resume"
                style={{ width: '1000px', height: '1135px' }}
                src={AndyResume + "#toolbar=0&navpanes=0"}
            />
        </p>
    )
}

export default Resume;