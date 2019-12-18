function I = MutualInformation(X,Y)
if (size(X,2) > 1)  % More than one predictor?
    % Axiom of information theory
    I = JointEntropy(X) + Entropy(Y) - JointEntropy([X Y]);
else
    % Axiom of information theory
    I = Entropy(X) + Entropy(Y) - JointEntropy([X Y]);
end
