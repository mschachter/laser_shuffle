function outVals = laserShuffleWrapper2()

% THIS IS THE MAIN SCRIPT TO ANALYZE LASER RESPONSES OF INDIVIDUAL UNITS

% fdir = uigetdir('C:\Data\Lex Data\D1 D2 recording CSV files');
% fdir = 'C:\Data\Lex Data\D1 D2 recording CSV files';
% fdir = 'C:\Data\Lex Data\2012-08-10 Laser Pulse Ranges';
% fdir = 'C:\Data\Lex Data\New D1-A2A data from Lex';
% fdir = 'F:\Data\Lex Data\All Files';
% fdir = 'C:\Data\Lex Data\OHDA Files';
% fdir = 'C:\Data\Lex Data\BlueGreenYellow CSVs';
fdir = uigetdir();
allFileList=ls(fdir);
numAllFiles=size(allFileList,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UN-COMMENT THE APPROPRIATE GROUP OF LINES IN ORDER TO PERFORM ANALYSIS  %
% THAT LASER PULSE CONDITION                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% paramVals.laserColName = 'ev_10msec';
% paramVals.psthWindow = [-1 2]; % (sec)
% paramVals.psthBinSize = 0.01; % (sec)
% paramVals.preLaserWindow = [-0.75 -0.25]; % (sec)
% paramVals.laserPulseWindow = [-0.01 0.05]; % (sec)

% paramVals.laserColName = {'ev_10msec10Hz'};
% paramVals.psthWindow = [-0.05 0.05]; % [-1 2]; %  
% paramVals.psthBinSize = 0.005; % 0.01; % sec
% paramVals.preLaserWindow = [-0.05 -0.01]; % [-0.75 -0.25]; % 
% paramVals.laserPulseWindow = [-0.01 0.05]; % [-0.3 1];

% paramVals.laserColName = 'ev_10msec20Hz';
% paramVals.psthWindow = [-0.02 0.03];%[-1 2];% 
% paramVals.psthBinSize = 0.0025; % 0.01; % sec
% paramVals.preLaserWindow = [-0.02 -0.01]; %[-0.75 -0.25];%
% paramVals.laserPulseWindow = [-0.01 0.05]; % [-0.3 1];

% paramVals.laserColName = 'ev_100msec';
% paramVals.psthWindow = [-1 2]; % (sec)
% paramVals.psthBinSize = 0.1; % (sec)
% paramVals.preLaserWindow = [-0.75 -0.25]; % (sec)
% paramVals.laserPulseWindow = [-0.2 1.5]; % (sec)

paramVals.laserColName = {'ev_100msec', 'ev_1sec', 'Laser_1', 'Noldus'};
paramVals.psthWindow = [-1 2]; % (sec)
paramVals.psthBinSize = 0.005; % (sec)
paramVals.preLaserWindow = [-0.75 -0.25]; % (sec)
paramVals.laserPulseWindow = [0 0.1]; % (sec)

% paramVals.laserColName = 'Laser_1';
% paramVals.psthWindow = [-1 2]; % (sec)
% paramVals.psthBinSize = 0.005; % (sec)
% paramVals.preLaserWindow = [-0.75 -0.25]; % (sec)
% paramVals.laserPulseWindow = [-0.2 1.5]; % (sec)

% paramVals.laserColName = {'BluePlugged1sec'};
% paramVals.psthWindow = [-1 2]; % (sec)
% paramVals.psthBinSize = 0.005; % (sec)
% paramVals.preLaserWindow = [-0.75 -0.25]; % (sec)
% paramVals.laserPulseWindow = [-0.2 1.5]; % (sec)

% paramVals.laserColName = {'BlueUnplugged1sec'};
% paramVals.psthWindow = [-1 2]; % (sec)
% paramVals.psthBinSize = 0.005; % (sec)
% paramVals.preLaserWindow = [-0.75 -0.25]; % (sec)
% paramVals.laserPulseWindow = [-0.2 1.5]; % (sec)

% paramVals.laserColName = {'GreenPlugged1sec'};
% paramVals.psthWindow = [-1 2]; % (sec)
% paramVals.psthBinSize = 0.005; % (sec)
% paramVals.preLaserWindow = [-0.75 -0.25]; % (sec)
% paramVals.laserPulseWindow = [-0.2 1.5]; % (sec)

% paramVals.laserColName = {'GreenUnplugged1sec'};	
% paramVals.psthWindow = [-1 2]; % (sec)
% paramVals.psthBinSize = 0.005; % (sec)
% paramVals.preLaserWindow = [-0.75 -0.25]; % (sec)
% paramVals.laserPulseWindow = [-0.2 1.5]; % (sec)

% paramVals.laserColName = {'YellowPlugged1sec'};	
% paramVals.psthWindow = [-1 2]; % (sec)
% paramVals.psthBinSize = 0.005; % (sec)
% paramVals.preLaserWindow = [-0.75 -0.25]; % (sec)
% paramVals.laserPulseWindow = [-0.2 1.5]; % (sec)

% paramVals.laserColName = {'YellowUnplugged1sec'};
% paramVals.psthWindow = [-1 2]; % (sec)
% paramVals.psthBinSize = 0.005; % (sec)
% paramVals.preLaserWindow = [-0.75 -0.25]; % (sec)
% paramVals.laserPulseWindow = [-0.2 1.5]; % (sec)

% paramVals.laserColName = 'ev_2msec';
% paramVals.laserColName = 'ev_2msec15mW';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 SET ANALYSIS PARAMETERS HERE                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

paramVals.numRandShifts = 5000; % Number of times to shuffle spike times from each trial
paramVals.percentileCutOff = 0.995; % Cut-off for determining a specific bin is significant
paramVals.randShiftMultiplier = 1; % (sec) Determines the magnitude of time randomized time shift
paramVals.pauseDur = 0; % (sec) Duration to pause after each plot; 0=no pause; -1 = wait for user
paramVals.minSpikesPerSigBin = 3;% 0.005; % Discard cells that don't have enough spikes to judge analysis
paramVals.minSigBins = 3; % Minimum number of bins that must be significant in order to count cell
paramVals.histHistBins = 0:1:5000; % Set bin size and range for histogram of PSTH values
paramVals.numDropFractions = 50; % Number of times to recompute the score omitting a fraction of the pulses
paramVals.selectCells = 0; % 1=query user for filename & cell; 0=analyze all files & cells
paramVals.highlightBinTimes = [-0.1 0.005 0.015 0.1]; % Bin times to highligh on plots

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       INITIALIZE SOME VARIABLES                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize arrays to hold all output values
% 2-d arrays of each time bin for each cell. 1=cell passed significance in
% that bin. 0=cell did not pass significance. MaxSigSum describes
% significant increases in firing. MinSigSum describes decreases
allLaserMinSigSum = []; 
allLaserMaxSigSum = [];
allLaserMaxSig = [];
allLaserMinSig = [];
allFirstSigMaxBin = []; % 1-d array of first bin during laser pulse to pass significance
totalCells = 0;

% Create histogram bins for peri-stimulus triggered histograms (PSTH)
paramVals.psthBins = ...
    paramVals.psthWindow(1):paramVals.psthBinSize:paramVals.psthWindow(2);
paramVals.laserPSTHBins = find(paramVals.psthBins >= paramVals.laserPulseWindow(1) & ...
    paramVals.psthBins < paramVals.laserPulseWindow(2));
paramVals.laserPSTHBins = (paramVals.laserPSTHBins(1)-1):paramVals.laserPSTHBins(end);
allCellNameList = {}; % List of cell names from all files
allPSTHBarVals = []; % Histogram of cell firing
allFileNums = 1:numAllFiles;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MAIN ANALYSIS LOOP                            %
%      FIND .CSV FILES IN DIRECTORY AND ANALYZE EACH ONE SEPARATELY       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% If user selecting individual cell, do that here
if paramVals.selectCells
    for fNum = allFileNums
        csvFile(fNum)= any(strfind(allFileList(fNum,:),'.csv'));
        if csvFile(fNum)
            disp([num2str(fNum), '  --  ', allFileList(fNum,:)]);
        end
    end
    badFileNum = 1;
    while badFileNum
        selFNum = input('Input file number: ');
        badFileNum = ~any(find(allFileNums(csvFile==1)==selFNum));
        if badFileNum
            disp(['Bad file number!']);
        else
            disp(['Reading file: ', allFileList(selFNum, :)]);
        end 
    end
    allFileNums = selFNum;
end

% Cycle through all identified csv files to analyze
for fNum = allFileNums
    csvFile(fNum)= any(strfind(allFileList(fNum,:),'.csv'));
    if csvFile(fNum)
        % Pick a file from the list, then eliminate extra spaces at 
        % the end of the filename
        fname{fNum} = allFileList(fNum,:);
        firstSpace = strfind(fname{fNum},'.csv '); 
        if any(firstSpace)
            fname{fNum}((firstSpace+4):end) = [];
        end
        outVals.fname{fNum} = fname{fNum};
        
        % Run the analysis
        fullFileName = fullfile(fdir, fname{fNum});
        shuffleAnalysisData = laserShuffleAnalysis(fullFileName, paramVals);
        
        % Add the results from analysis into a single list of all results
        if shuffleAnalysisData.numCells > 0
            allLaserMinSigSum = cat(1, allLaserMinSigSum, ...
                shuffleAnalysisData.laserMinSigSum);
            allLaserMaxSigSum = cat(1, allLaserMaxSigSum, ...
                shuffleAnalysisData.laserMaxSigSum);
            allLaserMaxSig = cat(1, allLaserMaxSig, ...
                shuffleAnalysisData.laserBinMaxSig);
            allLaserMinSig = cat(1, allLaserMinSig, ...
                shuffleAnalysisData.laserBinMinSig);
            allFirstSigMaxBin = cat(1, allFirstSigMaxBin, ...
                shuffleAnalysisData.firstSigMaxBin');
            totalCells = totalCells + shuffleAnalysisData.numCells;
        end
        disp(['size allLaserMaxSig: ', num2str(size(allLaserMaxSig))]);
        if shuffleAnalysisData.selCellNum == -1
            for cellNum = 1:shuffleAnalysisData.numCells
                allCellNameList = cat(1, allCellNameList, ...
                    [outVals.fname{fNum}, ' -- ', shuffleAnalysisData.cellName{cellNum}]);
            end
        else
            allCellNameList = cat(1, allCellNameList, ...
                [outVals.fname{fNum}, ' -- ', ...
                shuffleAnalysisData.cellName{shuffleAnalysisData.selCellNum}]);
        end
        allPSTHBarVals = cat(1, allPSTHBarVals, shuffleAnalysisData.psthBarVals);
    end
end

% Make a figure for plotting
allSumFig = figure('color','w');
allSumAx = axes('parent',allSumFig);

% Normalize values and copy to the output structure
outVals.allLaserMinSigSum = allLaserMinSigSum';
outVals.allLaserMaxSigSum = allLaserMaxSigSum';
outVals.totalCells = totalCells;
outVals.numCellInc = sum(outVals.allLaserMaxSigSum, 2) ./ outVals.totalCells;
outVals.numCellSup = sum(outVals.allLaserMinSigSum, 2) ./ outVals.totalCells;
outVals.laserBinTimes = paramVals.laserPulseWindow(1):...
    paramVals.psthBinSize:paramVals.laserPulseWindow(2);
outVals.allCellNames = strvcat(allCellNameList);
outVals.allPSTHBarVals = allPSTHBarVals;
outVals.allLaserMaxSig = allLaserMaxSig;
outVals.allLaserMinSig = allLaserMinSig;
outVals.allFirstSigMaxBin = allFirstSigMaxBin;

outVals.laserBinTimes = paramVals.psthBins(paramVals.laserPSTHBins) + ...
    (paramVals.psthBins(2) - paramVals.psthBins(1));

% Plot the summary data
bar(outVals.laserBinTimes, [outVals.numCellInc, outVals.numCellSup], ...
    'parent', allSumAx);
title(allSumAx, paramVals.laserColName, 'interpreter', 'none');
xlabel(allSumAx, 'Time (sec)');
ylabel(allSumAx, 'Frac Cells Responding');
end
