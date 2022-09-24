function projectCard({title, description, imgUrl}) {
  return (
        <div className="proj-imgbx">
            <img src={imgUrl} alt="Project"/>
            <div className="proj-txtx">
                <h4>{title}</h4>
                <span id="desc1">{description}</span>
            </div>
        </div>
  )
}

export default projectCard;