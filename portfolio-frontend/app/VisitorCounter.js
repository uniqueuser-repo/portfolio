'use client';
import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import axios from 'axios';

const VisitorCounterFunc = () => {
  const [visitorCount, setVisitorCount] = useState('Loading...');
  const router = useRouter();

  useEffect(() => {
    if (visitorCount === 'Loading...') {
      axios
        .post('https://api.aorlowski.com/viewerCount_getAndIncrement')
        .then((response) => {
          setVisitorCount(response.data);
        });
    }
  }, [router, visitorCount]);

  return <p title="This is the number of times all pages on my site have been visited." id="visitor_counter">Visit Counter: {visitorCount}</p>;
};

export default VisitorCounterFunc;