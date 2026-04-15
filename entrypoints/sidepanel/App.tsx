import { useState } from 'react';
import { useAgent } from '../../agent/useAgent';
import './App.css';

export default function App() {
  const [task, setTask] = useState('');
  const { status, history, activity, currentTask, execute, stop } = useAgent();

  const handleRun = async () => {
    if (!task) return;
    try {
      await execute(task);
    } catch (e) {
      console.error(e);
    }
  };

  return (
    <div className="popup-container">
      <h2 className="popup-title">My Page Agent</h2>
      
      <div className="popup-input-group">
        <input 
          type="text" 
          value={task}
          onChange={(e) => setTask(e.target.value)}
          placeholder="What do you want me to do?"
          disabled={status === 'running'}
          className="popup-input"
        />
        <button 
          onClick={handleRun} 
          disabled={status === 'running' || !task}
          className="popup-btn popup-btn-run"
        >
          Run
        </button>
        {status === 'running' && (
          <button 
            onClick={stop} 
            className="popup-btn popup-btn-stop"
          >
            Stop
          </button>
        )}
      </div>

      <div className="popup-status">
        <strong>Status:</strong> {status}
      </div>

      {activity && (
        <div className="popup-activity">
          <strong>Activity:</strong> {activity.type === 'executing' ? `Executing tool ${activity.tool}...` : activity.type}
        </div>
      )}

      {history.length > 0 && (
        <div className="popup-history">
          <h3 className="popup-history-title">History</h3>
          {history.map((event, index) => (
            <div key={index} className="popup-history-item">
              <strong>Step {index + 1}:</strong> {event.type}
              <br/>
              <span className="popup-history-msg">{(event as any).message || (event.type === 'error' ? (event as any).error?.message : 'No additional message')}</span>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
