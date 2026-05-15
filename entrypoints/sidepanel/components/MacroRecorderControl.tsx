import React, { useState } from 'react';

interface MacroRecorderControlProps {
  onStart: () => void;
  onStop: (macroName: string) => void;
}

export const MacroRecorderControl: React.FC<MacroRecorderControlProps> = ({ onStart, onStop }) => {
  const [isRecording, setIsRecording] = useState(false);
  const [macroName, setMacroName] = useState('');

  const handleToggle = () => {
    if (isRecording) {
      setIsRecording(false);
      onStop(macroName || `Macro_${Date.now()}`);
      setMacroName('');
    } else {
      setIsRecording(true);
      onStart();
    }
  };

  return (
    <div className="macro-recorder-container">
      <h3>Teach & Repeat Macro</h3>
      {!isRecording && (
        <input 
          type="text" 
          placeholder="Name your macro..." 
          value={macroName}
          onChange={(e) => setMacroName(e.target.value)}
          className="macro-input"
        />
      )}
      <button 
        className={`macro-button ${isRecording ? 'recording' : 'ready'}`}
        onClick={handleToggle}
        aria-label={isRecording ? 'Stop Recording Macro' : 'Start Recording Macro'}
      >
        {isRecording ? '⏹ Stop Recording' : '⏺ Start Recording'}
      </button>
      {isRecording && <p className="recording-status">Recording user events...</p>}
    </div>
  );
};
