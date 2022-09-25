import {  useState, useEffect } from 'react';
import axios from 'axios';

function VisitorCounter () {
    const [visitorCount, setVisitorCount] = useState('0')
    axios.post('https://8zro1fcvl5.execute-api.us-east-2.amazonaws.com/aorlowski_production/viewerCount_getAndIncrement')
        .then(response => console.log(response.data))
    return (
        <h1>hi</h1>
    )
}

export default VisitorCounter;