
import { Col } from 'react-bootstrap';

function projectCard({title, description, imgUrl}) {
  return (
      <Col sm={3} md={3}>
        <div className="proj-imgbx">
            <img src={imgUrl}/>
            <div className="proj-txtx">
                <h4>{title}</h4>
                <span>{description}</span>
            </div>
        </div>
      </Col>
  )
}

export default projectCard;