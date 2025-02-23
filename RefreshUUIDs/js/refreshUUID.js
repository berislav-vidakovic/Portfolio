import { v4 as uuidv4 } from 'https://esm.sh/uuid'; // Use a CDN

let foundUUIDs = [];
let newUUIDs = [];
let strFileContent = "";
let strFileName = "";


// Function that will be executed when the button is clicked
function loadFile() {
    // Create an invisible file input element
    const fileInput = document.createElement("input");
    fileInput.type = "file";
    fileInput.click(); // Trigger the file picker dialog
  
    // Handle file selection
    fileInput.addEventListener("change", function () {
        if (fileInput.files.length > 0) {
            const file =fileInput.files[0];
            const el = document.getElementById("show_File");
            strFileName = file.name;
            el.innerHTML = `<b>Uploaded file:</b> ${strFileName} <br />`;
            // Read file content
            const reader = new FileReader();
            reader.onload = function (event) {
              strFileContent = event.target.result;
              searchUUIDs();
            };
            reader.readAsText(file);
        }
    });
}

function buildTable(arHeaders, ...columns)
{
    let cssStyle = `<style>`;
    cssStyle += `table, th, td {`;
    cssStyle += `width: auto; border: 1.5px solid #000 }`;
    cssStyle += `</style>`;

    const nColumns = arHeaders.length;
    if( nColumns == 0 )
        return "";

    // Table open tag
    let htmlContent = cssStyle + `\n<table>\n`;

    // Build headers
    htmlContent += `<tr>\n`;
    for( let header of arHeaders)
        htmlContent += `<th>${header}</th>\n`;
    htmlContent += `</tr>\n`;

    // Get table row count as max column size
    let nRows = 0;
    for( let column of columns )
        if( column.length > nRows )
            nRows = column.length;

    // Build table rows
    let iRow = 0;
    while( iRow < nRows )
    {
        htmlContent += `<tr>\n`;     
        for( let column of columns )       
        { 
            let cellContent = "";
            if( column.length > iRow )
                cellContent = column[iRow];
            htmlContent += `<td>${cellContent}</td>\n`;
        }
        htmlContent += `</tr>\n`;
        iRow++;
    }

    // Table close tag
    htmlContent += "\n</table>";
    return  htmlContent;
}

function searchUUIDs()
{
    console.log("searchUUIDs");
    const uuidRegex = /\b[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\b/g;
    foundUUIDs = strFileContent.match(uuidRegex);
    const nUUIDs = foundUUIDs == null ? 0 : foundUUIDs.length;
    const el = document.getElementById("show_UUIDs");
    el.innerHTML = `<b>${nUUIDs} UUID(s) found</b> <br />`;

    let htmlTable = buildTable( ["UUID"], foundUUIDs );
    el.innerHTML += htmlTable;    

    if( nUUIDs > 0 )
        document.getElementById("userInstruction").innerHTML = `<b>Click on "Refresh UUIDs" button</b> to generate new UUIDs`;

}

function downloadFile()
{  
    if( newUUIDs.length == 0 )
        return;
    // Download file -----------------------------------------------------

    // Create a blob from updated content
    const blob = new Blob([strFileContent], { type: "text/plain" });

    // Create a link to download the file
    const a = document.createElement("a");
    a.href = URL.createObjectURL(blob);

    //const fileName = prompt("Enter file name:", "updated_file.txt");

    if( strFileName )
    {
        a.download = strFileName;
        document.body.appendChild(a);
        a.click();

        // Cleanup
        document.body.removeChild(a);
        URL.revokeObjectURL(a.href);
    }    
    const elUserInst = document.getElementById("userInstruction"); 
    elUserInst.innerHTML = "File with new UUIDs downloaded successfully!<br />";
    elUserInst.innerHTML += `<b>Click on "Upload..." button</b> to select the file that contains UUIDs`;

}

function refreshUUIDs()
{
    const nUUIDs = foundUUIDs == null ? 0 : foundUUIDs.length;
    if( nUUIDs == 0 )
        return;
        
    newUUIDs = [];
    for( let i = 0; i< nUUIDs; i++ )
        newUUIDs.push(uuidv4());        

    const htmlTable = buildTable( ["Old UUID", "New UUID"], foundUUIDs, newUUIDs );

    const el = document.getElementById("show_UUIDs");

    el.innerHTML = `<b>Following replacements are to be made </b>`;

    const dt = new Date();
    el.innerHTML += ` [new UUIDs generated on ${dt.toUTCString()}]<br />`;

    el.innerHTML += htmlTable;

    

    let iIndex = 0;
    for( let uuid of foundUUIDs )
        strFileContent = strFileContent.replace(uuid, newUUIDs[iIndex++]);

    const elUserInst = document.getElementById("userInstruction"); 
    let accHTML = `To Confirm replacement and download <b>Click on "Download" button</b>`;
    accHTML += `<br />To generate new UUIDs click on "Refresh UUIDs" button`;
    accHTML += `<br />To upload new file with UUIDs click on "Upload..." button`;
    elUserInst.innerHTML = accHTML;
}

// Attach event listeners
document.addEventListener("DOMContentLoaded", function () {
    const btnUpload = document.getElementById("btnUpload");
    btnUpload.addEventListener("click", loadFile);

    const btnRefresh= document.getElementById("btnRefresh");
    btnRefresh.addEventListener("click", refreshUUIDs);

    const btnDownload = document.getElementById("btnDownload");
    btnDownload.addEventListener("click", downloadFile);

});
