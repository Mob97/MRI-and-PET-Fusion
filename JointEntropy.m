function H = JointEntropy(X)
% Sort to get identical records together
X = sortrows(X);
% Find elemental differences from predecessors
DeltaRow = (X(2:end,:) ~= X(1:end-1,:));
% Summarize by record
Delta = [1; any(DeltaRow')'];
% Generate vector symbol indices
VectorX = cumsum(Delta);
% Calculate entropy the usual way on the vector symbols
H = Entropy(VectorX);

