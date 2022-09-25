import {  useState } from 'react';
import axios from 'axios';

function VisitorCounter () {
    const [visitorCount, setVisitorCount] = useState(-1)
    if (visitorCount == -1) {
        axios.post('https://8zro1fcvl5.execute-api.us-east-2.amazonaws.com/aorlowski_production/viewerCount_getAndIncrement')
            .then((response) => {
                setVisitorCount(response.data)
            })
    }
    return (
        <h1>Visitor Counter: {visitorCount}</h1>
    )
}

export default VisitorCounter;