import htmlmin from "html-minifier-terser";

export function htmlminTransform(content) {
    if ((this.page.outputPath || "").endsWith(".html")) {
        let minified = htmlmin.minify(content, {
            useShortDoctype: true,
            removeComments: true,
            collapseWhitespace: true,
            minifyCSS: true,
            minifyJS: true,
            sortClassName: true
        });
        return minified;
    }

    // If not an HTML output, return content as-is
    return content;
}