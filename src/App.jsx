import React, { useEffect, useState } from 'react';

function App() {
  const [message, setMessage] = useState('');

  useEffect(() => {
    fetch(`http://localhost:5000/api/hello`)
      .then(res => res.json())
      .then(data => setMessage(data.message))
      .catch(err => console.error(err));
  }, []);

  return (
    <div style={{ padding: 50 }}>
      <h1>Vite + Node Docker Sample</h1>
      <p>{message || 'Loading...'}</p>
    </div>
  );
}

export default App;
