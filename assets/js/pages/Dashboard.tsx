import { Head } from "@inertiajs/react";
import React, { useState } from "react";

const Dashboard: React.FC = () => {
  const [count, setCount] = useState<number>(0);

  const increment = (): void => {
    setCount(count + 1);
  };

  const decrement = (): void => {
    setCount(count - 1);
  };

  return (
    <div>
      <Head title="Dashboard" />
      <div className="flex flex-col items-center gap-4">
        <h2 className="text-2xl font-bold">Counter: {count}</h2>
        <div className="flex gap-4">
          <button
            type="button"
            onClick={decrement}
            className="px-4 py-2 bg-red-500 text-white rounded"
          >
            Decrement
          </button>
          <button
            type="button"
            onClick={increment}
            className="px-4 py-2 bg-green-500 text-white rounded"
          >
            Increment
          </button>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
