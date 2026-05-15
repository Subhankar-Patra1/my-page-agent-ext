import React from 'react';

type AgentState = 'idle' | 'thinking' | 'acting' | 'error';

interface AgentStatusGlowProps {
  status: AgentState;
}

export const AgentStatusGlow: React.FC<AgentStatusGlowProps> = ({ status }) => {
  const getStatusColor = () => {
    switch (status) {
      case 'idle':
        return 'var(--color-primary)';
      case 'thinking':
        return 'var(--color-success-glow)';
      case 'acting':
        return 'var(--color-recording-red)';
      case 'error':
        return 'red';
      default:
        return 'var(--color-primary)';
    }
  };

  const getStatusText = () => {
    switch (status) {
      case 'idle': return 'Agent is Idle';
      case 'thinking': return 'Vision Fallback Processing...';
      case 'acting': return 'Executing Actions...';
      case 'error': return 'Error / Hardware Limit Reached';
      default: return 'Idle';
    }
  };

  return (
    <div className="agent-status-container" aria-live="polite">
      <div 
        className={`status-glow ${status}`} 
        style={{ backgroundColor: getStatusColor() }}
      />
      <span className="status-text">{getStatusText()}</span>
    </div>
  );
};
