function InitializeProject()
    
    % Fix randomness
    rng('default');
    
    % Get the calling file's directory
    callerPath = matlab.desktop.editor.getActiveFilename;
    projectRoot = fileparts(callerPath);
    
    % Clean up paths first
    restoredefaultpath;
    
    % Add shared library folder
    pathLib = fullfile('..', '..', 'lib');
    addpath(genpath(pathLib));
    
    % Add project-specific folders
    addpath(genpath(fullfile(projectRoot, 'src')));
    addpath(genpath(fullfile(projectRoot, 'data')));
    addpath(genpath(fullfile(projectRoot, 'results')));
    
    % Define paths in caller workspace
    assignin('base', 'pathResults', fullfile(projectRoot, 'results'));
    assignin('base', 'pathFigures', fullfile(projectRoot, 'results', 'figures'));
    assignin('base', 'pathSrc', fullfile(projectRoot, 'src'));
    assignin('base', 'pathDataRaw', fullfile(projectRoot, 'data', 'raw'));
    assignin('base', 'pathDataInterim', fullfile(projectRoot, 'data', 'interim'));
    assignin('base', 'pathDataProcessed', fullfile(projectRoot, 'data', 'processed'));
    assignin('base', 'pathLib', pathLib);

end