import React, {  useState } from 'react';
import axios from 'axios';

class VisitorCounterClass extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            visitorCount: 'Loading...'
        }
    }

    componentDidMount() {
        if (this.state.visitorCount === 'Loading...') {
            axios.post('https://api.aorlowski.com/viewerCount_getAndIncrement')
            .then((response) => {
                this.setState({visitorCount: response.data})
            })
        }
    }

    render() {
        return (
            <p id="visitor_counter">Visitor Counter: {this.state.visitorCount}</p>
        )
    }
}

export default VisitorCounterClass;