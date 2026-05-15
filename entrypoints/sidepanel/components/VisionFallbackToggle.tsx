import React from 'react';

interface VisionFallbackToggleProps {
  isEnabled: boolean;
  vramAvailable: number; // in GB
  onToggle: (enabled: boolean) => void;
}

export const VisionFallbackToggle: React.FC<VisionFallbackToggleProps> = ({ isEnabled, vramAvailable, onToggle }) => {
  const isSupported = vramAvailable >= 16;

  return (
    <div className="vision-toggle-container">
      <div className="toggle-header">
        <h3>Gemma 4 Vision Fallback</h3>
        <span className="vram-badge">{vramAvailable}GB VRAM</span>
      </div>
      
      <label className="toggle-switch">
        <input 
          type="checkbox" 
          checked={isEnabled && isSupported}
          disabled={!isSupported}
          onChange={(e) => onToggle(e.target.checked)}
          aria-checked={isEnabled && isSupported}
          role="switch"
        />
        <span className="slider round"></span>
      </label>
      
      {!isSupported && (
        <p className="warning-text">Hardware unsupported: Requires ≥16GB VRAM.</p>
      )}
    </div>
  );
};
