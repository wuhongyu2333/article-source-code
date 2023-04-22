function z = boundary(x)
    z = round(x);
    z = max(z,1);
    z = min(z,65);
end