'use client';
import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import axios from 'axios';

const VisitorCounterFunc = () => {
  const [visitorCount, setVisitorCount] = useState('Loading...');
  const router = useRouter();

  useEffect(() => {
    console.log(router);
    console.log(router.pathname);
    if (visitorCount === 'Loading...') {
      axios
        .post('https://api.aorlowski.com/viewerCount_getAndIncrement')
        .then((response) => {
          setVisitorCount(response.data);
        });
    }
  }, [router, visitorCount]);

  return <p id="visitor_counter">Visitor Counter: {visitorCount}</p>;
};

export default VisitorCounterFunc;