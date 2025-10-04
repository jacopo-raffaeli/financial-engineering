classdef PlotUtils
    methods(Static)
        
        function setStyle()
            % Apply consistent style to current axes
            set(gca,'FontName','Times New Roman','FontSize',12, ...
                'LineWidth',1,'Box','off','TickDir','out');
            set(findall(gca,'Type','Line'),'LineWidth',1.5);
            grid off;
        end
        
        function setLabels(xlab, ylab, titleText)
            % Add axis labels and title with proper formatting
            xlabel(xlab,'FontSize',12,'Interpreter','latex');
            ylabel(ylab,'FontSize',12,'Interpreter','latex');
            if ~isempty(titleText)
                title(titleText,'FontSize',14,'Interpreter','latex');
            end
        end
        
        function setLegend(location)
            if nargin < 1
                location = 'best';
            end
        
            % Get all children of current axes
            axChildren = gca().Children;
        
            % Filter visible objects with DisplayName
            objs = axChildren(arrayfun(@(h) isprop(h,'DisplayName') && ~isempty(h.DisplayName) && h.Visible, axChildren));
        
            % Reverse to match plotting order
            objs = flipud(objs);
        
            % Keep only the first object for each unique DisplayName
            [~, ia] = unique({objs.DisplayName}, 'stable');
            objs = objs(ia);
        
            if isempty(objs)
                warning('No plotted objects with DisplayName found. Legend will not be shown.');
                return
            end
        
            % Create legend
            legend(objs, 'Location', location, 'FontSize', 10, 'Interpreter', 'latex', 'Box', 'off');
        end

        function saveFigure(figHandle, fileName, folderName, formats)            
            if nargin < 4
                formats = {'pdf'};
            end
        
            % Set transparent background
            figHandle.Color = 'w';  
            ax = figHandle.CurrentAxes;
            if ~isempty(ax)
                ax.Color = 'w';             
                ax.XColor = 'k';          
                ax.YColor = 'k';            
                ax.ZColor = 'k';
                ax.FontSize = 12;
                ax.FontName = 'Times New Roman';
            end
        
            % Loop over requested formats
            for f = formats
                ext = f{1};
                filePath = fullfile(folderName,[fileName '.' ext]);
                switch ext
                    case 'pdf'
                        exportgraphics(figHandle, filePath, 'ContentType','vector');
                    case 'eps'
                        print(figHandle,'-depsc',filePath);
                    case 'png'
                        exportgraphics(figHandle, filePath,'Resolution',600);
                    otherwise
                        warning('Unsupported format: %s',ext);
                end
            end
        end        
    end
end
