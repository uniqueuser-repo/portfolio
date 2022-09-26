import {  useState } from 'react';
import axios from 'axios';

function VisitorCounter () {
    const [visitorCount, setVisitorCount] = useState('Loading...')
    if (visitorCount === 'Loading...') {
        axios.post('https://api.aorlowski.com/viewerCount_getAndIncrement')
            .then((response) => {
                setVisitorCount(response.data)
            })
    }
    return (
        <p id="visitor_counter">Visitor Counter: {visitorCount}</p>
    )
}

export default VisitorCounter;