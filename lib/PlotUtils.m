classdef PlotUtils
    % Utility class for creating plots
    methods(Static)

        function setStyle()
            % Apply global plotting style
        
            % Font and axes
            ax = gca;
            set(ax, 'FontName', 'Times', ...
                'FontSize', 11, ...
                'LineWidth', 0.8, ...
                'Box', 'on', ...
                'TickDir', 'out', ...
                'XColor', 'k', ...
                'YColor', 'k');
        
            % Grid (subtle, optional)
            grid off;
            set(ax, 'GridLineStyle', ':', ...
                'GridColor', [0.85 0.85 0.85], ...
                'MinorGridLineStyle', ':', ...
                'GridAlpha', 0.5);
        
            % Line styles and color order 
            colorOrder = [...
                0, 0, 0;          % black 
                0.3, 0.3, 0.3;    % dark gray
                0, 0, 0.6;        % dark blue
                0.6, 0, 0;        % dark red
                0, 0.5, 0;        % dark green
                0.5, 0, 0.5];     % purple
            set(groot, 'defaultAxesColorOrder', colorOrder);
        
            % Update existing lines
            lines = findall(ax, 'Type', 'Line');
            for i = 1:numel(lines)
                set(lines(i), 'LineWidth', 1.2);
            
                % Apply consistent marker style if marker is defined
                m = lines(i).Marker;
                if ~isempty(m) && ~strcmp(m,'none')
                    col = lines(i).Color;
                    if isempty(col) || isequal(col,'none')
                        col = [0 0 0];  % fallback to black
                    end
            
                    edgeCol = [0 0 0];
                    set(lines(i), ...
                        'MarkerFaceColor', col, ...
                        'MarkerEdgeColor', edgeCol, ...
                        'MarkerSize', 3);
                end
            end
        end

        function setLabels(xlab, ylab, titleText)
            % Set axis labels and title with LaTeX interpreter
            xlabel(xlab, 'FontSize', 12, 'Interpreter', 'latex');
            ylabel(ylab, 'FontSize', 12, 'Interpreter', 'latex');
            if ~isempty(titleText)
                title(titleText, 'FontSize', 13, 'Interpreter', 'latex');
            end
        end

        function setLegend(location)
            % Automatically attach legend to plotted objects with DisplayName
            if nargin < 1
                location = 'best';
            end

            axChildren = gca().Children;
            objs = axChildren(arrayfun(@(h) isprop(h,'DisplayName') && ...
                ~isempty(h.DisplayName) && h.Visible, axChildren));
            objs = flipud(objs);
            [~, ia] = unique({objs.DisplayName}, 'stable');
            objs = objs(ia);

            if isempty(objs)
                warning('No plotted objects with DisplayName found. Legend not shown.');
                return;
            end

            legend(objs, 'Location', location, ...
                'FontSize', 10, 'Interpreter', 'latex', ...
                'Box', 'off', 'NumColumns', 1);
        end

        function saveFigure(figHandle, fileName, folderName, formats)
            % Save figure with transparent background and academic quality
            if nargin < 4
                formats = {'pdf'};
            end
            if nargin < 3 || isempty(folderName)
                folderName = 'figures';
            end
            if ~exist(folderName, 'dir')
                mkdir(folderName);
            end

            % Style
            figHandle.Color = 'none';
            set(figHandle, 'InvertHardcopy', 'off');  % preserve transparency

            % Export each format
            for f = formats
                ext = f{1};
                filePath = fullfile(folderName, [fileName '.' ext]);
                switch ext
                    case 'pdf'
                        exportgraphics(figHandle, filePath, ...
                            'ContentType', 'vector', 'BackgroundColor', 'none');
                    case 'eps'
                        print(figHandle, '-depsc', '-vector', filePath);
                    case 'png'
                        exportgraphics(figHandle, filePath, ...
                            'Resolution', 600, 'BackgroundColor', 'none');
                    otherwise
                        warning('Unsupported format: %s', ext);
                end
            end
        end
    end
end
