import {  useState } from 'react';
import axios from 'axios';

function VisitorCounter () {
    const [visitorCount, setVisitorCount] = useState('Loading...')
    if (visitorCount === 'Loading...') {
        axios.post('https://8zro1fcvl5.execute-api.us-east-2.amazonaws.com/aorlowski_production/viewerCount_getAndIncrement')
            .then((response) => {
                setVisitorCount(response.data)
            })
    }
    return (
        <p id="visitor_counter">Visitor Counter: {visitorCount}</p>
    )
}

export default VisitorCounter;