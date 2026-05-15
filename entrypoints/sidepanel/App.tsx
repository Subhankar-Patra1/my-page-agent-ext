import { useState } from 'react';
import { useAgent } from '../../agent/useAgent';
import { AgentStatusGlow } from './components/AgentStatusGlow';
import { MacroRecorderControl } from './components/MacroRecorderControl';
import { VisionFallbackToggle } from './components/VisionFallbackToggle';
import './App.css';

export default function App() {
  const [task, setTask] = useState('');
  const [visionEnabled, setVisionEnabled] = useState(true);
  const { status, history, activity, currentTask, execute, stop } = useAgent();

  const handleRun = async () => {
    if (!task) return;
    try {
      await execute(task);
    } catch (e) {
      console.error(e);
    }
  };

  const mapStatus = () => {
    if (status === 'running') {
      if (activity?.type === 'executing' && activity.tool === 'visionFallback') return 'thinking';
      return 'acting';
    }
    if (status === 'error') return 'error';
    return 'idle';
  };

  const handleMacroStart = () => {
    console.log("Macro recording started");
  };

  const handleMacroStop = (macroName: string) => {
    console.log(`Macro ${macroName} saved`);
  };

  return (
    <div className="popup-container theme-dark">
      <header className="popup-header">
        <h2 className="popup-title">Oryonix V2</h2>
        <AgentStatusGlow status={mapStatus()} />
      </header>
      
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

      <div className="controls-section">
        <VisionFallbackToggle 
          isEnabled={visionEnabled} 
          vramAvailable={16} // Mocked hardware limit check
          onToggle={setVisionEnabled} 
        />
        
        <MacroRecorderControl 
          onStart={handleMacroStart} 
          onStop={handleMacroStop} 
        />
      </div>

      {activity && (
        <div className="popup-activity">
          <strong>Activity:</strong> {activity.type === 'executing' ? `Executing ${activity.tool}...` : activity.type}
        </div>
      )}

      {history.length > 0 && (
        <div className="popup-history">
          <h3 className="popup-history-title">Execution Log</h3>
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
